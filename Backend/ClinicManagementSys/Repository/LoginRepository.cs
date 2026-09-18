using ClinicManagementSys.Model;
using ClinicManagementSys.ViewModel;
using Microsoft.EntityFrameworkCore;

namespace ClinicManagementSys.Repository
{
    public class LoginRepository : ILoginRepository
    {
        private readonly ClinicManagementSysContext _context;

        public LoginRepository(ClinicManagementSysContext context)
        {
            _context = context;
        }

        public async Task<LoginRegistrationViewModel?> ValidateUsers(string username, string password)
        {
            try
            {
                if (_context == null || string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
                {
                    return null;
                }

                // Retrieve user record by username
                var user = await _context.LoginRegistrations
                    .Include(u => u.Role)
                    .FirstOrDefaultAsync(u => u.Username == username);

                if (user == null)
                {
                    return null;
                }

                // Check account active state (if explicitly set to false, reject)
                if (user.RisActive == false)
                {
                    return null;
                }

                // Verify password (supports BCrypt and legacy plain text with auto-upgrade)
                bool isValid = PasswordHasher.VerifyPassword(password, user.Password, out bool needsUpgrade);
                if (!isValid)
                {
                    return null;
                }

                // Transparent password hash migration on successful login
                if (needsUpgrade)
                {
                    try
                    {
                        user.Password = PasswordHasher.HashPassword(password);
                        await _context.SaveChangesAsync();
                    }
                    catch
                    {
                        // Non-blocking: proceed with login if background save fails
                    }
                }

                // Find linked doctor id if Role is Doctor (RoleId 2)
                int? doctorId = null;
                if (user.RoleId == 2)
                {
                    doctorId = await _context.Doctors
                        .Where(d => d.RegistrationId == user.RegistrationId)
                        .Select(d => (int?)d.DoctorId)
                        .FirstOrDefaultAsync();
                }

                return new LoginRegistrationViewModel
                {
                    Username = user.Username,
                    RoleId = user.RoleId,
                    RoleName = user.Role?.RoleName ?? string.Empty,
                    StaffId = user.StaffId,
                    RegistrationId = user.RegistrationId,
                    DoctorId = doctorId
                };
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
