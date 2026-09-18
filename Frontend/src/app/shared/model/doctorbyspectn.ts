import { Specialization } from "./specialization";
import { User } from "./user";

export class Doctorbyspectn {
    DoctorId: number = 0;
    ConsultationFee: number = 0.0;
    DoctorIsActive: boolean = false;
  
    users: User = new User();
    specialization: Specialization = new Specialization();
}
