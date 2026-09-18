import { Category } from "./category";

export class Medicinedetails {
    MedicineId: number=0;
    MedicineName: string='';
    ManufacturingDate: Date = new Date();
    ExpiryDate: Date = new Date();
    CategoryId: number = 0;
    Cost: number = 0;
    IsActive: boolean = false ;

    //object Oriented Model
    category : Category = new Category();
}
