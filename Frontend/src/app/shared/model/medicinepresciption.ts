import { Medicinedetails } from "./medicinedetails";

export class Medicinepresciption {

    PrescriptionId: number=0;
    AppointmentId: number=0;
    MedicineId: number=0;
    MedicineName: string='';
    Dosage: string='';
    Frequency: string='';
    StaffName: string='';
    NumberofDays: number=0;
    PatientName: string='';

    //object Oriented Model
    Medicinedetails : Medicinedetails = new Medicinedetails();
}
