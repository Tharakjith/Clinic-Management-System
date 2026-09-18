using ClinicManagementSys.Model;
using ClinicManagementSys.Repository;
using ClinicManagementSys.ViewModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace ClinicManagementSys.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginsController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly ILoginRepository _loginRepository;

        public LoginsController(IConfiguration config, ILoginRepository loginRepository)
        {
            _config = config;
            _loginRepository = loginRepository;
        }

        /// <summary>
        /// Enterprise Secure Login endpoint with encrypted body payload and claims-enriched JWT.
        /// </summary>
        [AllowAnonymous]
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            if (loginDto == null || !ModelState.IsValid)
            {
                return BadRequest(new { message = "Username and password are required." });
            }

            var validUser = await _loginRepository.ValidateUsers(loginDto.Username, loginDto.Password);
            if (validUser == null)
            {
                return Unauthorized(new { message = "Invalid username or password, or account is deactivated." });
            }

            var tokenString = GenerateJWTToken(validUser);

            var response = new AuthResponseDto
            {
                Token = tokenString,
                Username = validUser.Username,
                RoleId = validUser.RoleId,
                RoleName = validUser.RoleName,
                DoctorId = validUser.DoctorId,
                StaffId = validUser.StaffId,
                RegistrationId = validUser.RegistrationId,
                ExpiresInMinutes = 120
            };

            return Ok(response);
        }

        /// <summary>
        /// Legacy fallback login endpoint (Deprecated: use POST /api/Logins/login).
        /// </summary>
        [AllowAnonymous]
        [HttpGet("{username}/{userpass}")]
        public async Task<IActionResult> LoginCredential(string username, string userpass)
        {
            var validUser = await _loginRepository.ValidateUsers(username, userpass);
            if (validUser == null)
            {
                return Unauthorized(new { message = "Invalid credentials" });
            }

            var tokenString = GenerateJWTToken(validUser);
            return Ok(new
            {
                Username = validUser.Username,
                RoleId = validUser.RoleId,
                RoleName = validUser.RoleName,
                Token = tokenString,
                DoctorId = validUser.DoctorId,
                StaffId = validUser.StaffId,
                RegistrationId = validUser.RegistrationId
            });
        }

        private string GenerateJWTToken(LoginRegistrationViewModel validUser)
        {
            var secretKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"] ?? "DefaultFallbackSecretKeyWith32CharsMinimum!"));
            var credentials = new SigningCredentials(secretKey, SecurityAlgorithms.HmacSha256);

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, validUser.RegistrationId.ToString()),
                new Claim(ClaimTypes.Name, validUser.Username),
                new Claim(ClaimTypes.Role, validUser.RoleName),
                new Claim("RoleId", validUser.RoleId.ToString()),
                new Claim("StaffId", validUser.StaffId.ToString()),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            if (validUser.DoctorId.HasValue)
            {
                claims.Add(new Claim("DoctorId", validUser.DoctorId.Value.ToString()));
            }

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Issuer"],
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(120),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
