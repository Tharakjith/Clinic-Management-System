import { LoginRegistration } from "./login-registration";

export class Doctor {
    "DoctorId": number = 0;
    "ConsultationFee": number = 0;
    "SpecializationId": number = 0;
    "RegistrationId": number = 0;
    "DoctorIsActive":  boolean = false;

 loginRegistration:LoginRegistration= new LoginRegistration();
}
