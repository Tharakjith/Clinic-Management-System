export class Medicinebill {
    AppointmentId: number = 0;
    PatientId: number = 0;
    PatientName: string = '';
    MedicineName: string = '';
    BillDateTime: Date = new Date();
    Dosage:string = '';
    Frequency: string = '';
    NumberOfDays: number = 0;
    Cost: number = 0.00;

    
}
