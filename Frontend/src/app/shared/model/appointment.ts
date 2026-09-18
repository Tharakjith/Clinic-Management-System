import { Availability } from "./availability";
import { Doctors } from "./doctors";
import { Patient } from "./patient";
import { Specialization } from "./specialization";

export class Appointment {
    PatientId: number = 0;
    SpecializationId: number = 0;
    DoctorId: number = 0;
    AvailabilityId: number = 0;
    AppointmentDate: string = '';
    TokenNumber: number = 0;
    ConsultationFee: number = 0;

    patient: Patient = new Patient();
    specialization: Specialization = new Specialization();
    doctor: Doctors = new Doctors();
    availability: Availability = new Availability();


}
