namespace ClinicManagementSys.ViewModel
{
    public class AuthResponseDto
    {
        public string Token { get; set; } = string.Empty;
        public string Username { get; set; } = string.Empty;
        public int RoleId { get; set; }
        public string RoleName { get; set; } = string.Empty;
        public int? DoctorId { get; set; }
        public int StaffId { get; set; }
        public int RegistrationId { get; set; }
        public int ExpiresInMinutes { get; set; } = 120;
    }
}
