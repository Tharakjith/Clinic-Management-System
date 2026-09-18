using BCrypt.Net;

namespace ClinicManagementSys.Repository
{
    public static class PasswordHasher
    {
        /// <summary>
        /// Hashes a plaintext password using BCrypt with work factor 11.
        /// </summary>
        public static string HashPassword(string password)
        {
            if (string.IsNullOrEmpty(password))
            {
                throw new ArgumentNullException(nameof(password));
            }
            return BCrypt.Net.BCrypt.HashPassword(password, workFactor: 11);
        }

        /// <summary>
        /// Verifies a password against the stored string.
        /// Supports legacy plaintext passwords with an automatic upgrade flag.
        /// </summary>
        public static bool VerifyPassword(string password, string storedPassword, out bool needsUpgrade)
        {
            needsUpgrade = false;

            if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(storedPassword))
            {
                return false;
            }

            // Detect BCrypt hash signatures ($2a$, $2b$, $2y$)
            if (storedPassword.StartsWith("$2a$") || storedPassword.StartsWith("$2b$") || storedPassword.StartsWith("$2y$"))
            {
                try
                {
                    return BCrypt.Net.BCrypt.Verify(password, storedPassword);
                }
                catch
                {
                    return false;
                }
            }

            // Legacy Plaintext fallback: check exact match and flag for auto-upgrade
            if (password == storedPassword)
            {
                needsUpgrade = true;
                return true;
            }

            return false;
        }
    }
}
