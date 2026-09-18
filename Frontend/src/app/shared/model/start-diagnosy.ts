
//import { Doctor } from "./doctor";

import { Appointment } from "./appointment";

export class StartDiagnosy {

    "HistoryId": number = 0;
    "Diagnosis": string='';
    "Symptoms": string='';
    "NextVisiting":Date = new Date();
    "DoctorNote":number = 0;
    "DiagnosysDate": string='';
    "DateTime": Date = new Date();
    "Reference": number = 0;
    "AppointmentId": number = 0;
    "IsActive": boolean;
    
    appointment:Appointment=new Appointment();
  


   
}
