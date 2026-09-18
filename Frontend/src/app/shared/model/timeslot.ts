import { Weekdays } from "./weekdays";

export class Timeslot {
    timeSlotId: number = 0;
    startTime: string = "";
    endTime: string = "";
    weekdaysId: number = 0;

    weekdays : Weekdays = new Weekdays();
}
