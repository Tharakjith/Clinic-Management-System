using ClinicManagementSys.ViewModel;

namespace ClinicManagementSys.Repository
{
    public interface ILoginRepository
    {
        Task<LoginRegistrationViewModel?> ValidateUsers(string username, string password);
    }
}
