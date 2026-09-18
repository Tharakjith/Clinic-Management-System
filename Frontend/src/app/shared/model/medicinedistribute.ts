import { Medicinedetails } from "./medicinedetails";
import { Patient } from "./patient";
import { Prescription } from "./prescription";

export class Medicinedistribute {
    PrescriptionId: number=0;
    MedicineId: number=0;
    QuantityDistributed: number=0;
    DistributionDate:  Date = new Date();
    PatientName:string='';
    MedicineName: string='';
    Dosage: string='';
    Frequency: string='';
    NumberofDays: number=0;
    StockInHand: number=0;

    prescription:Prescription = new Prescription();
    medicinedetails:Medicinedetails = new Medicinedetails();
    patient:Patient = new Patient();

}
