import { Doctors } from "./doctors";
import { Timeslot } from "./timeslot";

export class Availability {
    availabilityId: number = 0;
    doctorId: number = 0;
    timeSlotId: number = 0;
    session: string = "";

    doctors : Doctors = new Doctors();
    timeslot : Timeslot = new Timeslot();
}
