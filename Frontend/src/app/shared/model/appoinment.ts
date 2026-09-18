import { Availability } from "./availability";
import { Doctor } from "./doctor";
import { Patient } from "./patient";

export class Appoinment {
    "AppointmentId": number = 0;
    "PatientId": string='';
    "SpecializationId": string='';
    "DoctorId": string='';
    "AvailabilityId":number = 0;
    "AppointmentDate": Date = new Date();
    "ConsultationFee": number = 0;
    "RegistrationFee": number = 0;
    "TokenNumber": number = 0;
    "AppointmentStatusId": number = 0;
   //object Orented Model
   
   patient : Patient = new Patient();
   doctor : Doctor = new Doctor();
   availability : Availability = new Availability();
   


}
