import { Doctors } from "./doctors";
import { Patient } from "./patient";

export class AppoinmentpatientViewmodel {
    
    "PatientId": number = 0;
    "PatientName": string='';
    "doctorId":number = 0;
    "Dob":  Date = new Date();
    "Gender":string='';
    "BloodGroup": string='';
    "PatientPhone": string='';
    "PatientAddress": string='';
    "RegistrationDate": Date = new Date();
    "AppointmentId": number = 0;
    "AppointmentDate":  Date = new Date();
    "TokenNumber": number = 0;
    "SpecializationName": string='';
    
patient : Patient = new Patient();
doctor : Doctors = new Doctors();

    
  
}


