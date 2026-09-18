namespace ClinicManagementSys.ViewModel
{
    public class LoginRegistrationViewModel
    {
        public string Username { get; set; } = string.Empty;
        public int RoleId { get; set; }
        public string RoleName { get; set; } = string.Empty;
        public int StaffId { get; set; }
        public int RegistrationId { get; set; }
        public int? DoctorId { get; set; }
    }
}
