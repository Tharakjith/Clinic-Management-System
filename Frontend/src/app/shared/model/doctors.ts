import { Registration } from "./registration";
import { Specialization } from "./specialization";
import { Staff } from "./staff";

export class Doctors {
  DoctorId: number = 0;
  RegistrationId: number = 0;
  StaffId: number = 0;
  SpecializationId: number = 0;
  ConsultationFee: number = 0.00;
  DoctorIsActive: boolean = false;

  Staff: Staff = new Staff();
  Registration: Registration = new Registration();
  Specialization: Specialization = new Specialization();
}