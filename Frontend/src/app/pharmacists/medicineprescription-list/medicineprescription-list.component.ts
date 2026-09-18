import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MedicinedistributeService } from 'src/app/shared/service/medicinedistribute.service';
import { MedicinepresciptionService } from 'src/app/shared/service/medicinepresciption.service';


@Component({
  selector: 'app-medicineprescription-list',
  templateUrl: './medicineprescription-list.component.html',
  styleUrls: ['./medicineprescription-list.component.scss']
})
export class MedicineprescriptionListComponent implements OnInit {

  //declare variables

  page: number=1;
  pageSize: number=10;
  searchTerm: string='';

  constructor(
    public medicinedistributeService:MedicinedistributeService,
    public medicineprescriptionService: MedicinepresciptionService,
    private router : Router,private toastr: ToastrService) { }

  ngOnInit(): void {
    console.log("hi I am MedicinepresciptionService Component");
    this.medicineprescriptionService.getAllMedicinePrescriptions();
  }

  getMedicineName(medicineId: number): string {
    const medicine = this.medicineprescriptionService.medicinedetails.find(c => c.MedicineId === medicineId);
    return medicine ? medicine.MedicineName : 'Unknown';
  }
//Search Method
  //1. Based on searchterm, employee Service.employees should populate
  filteredMedicinePrescriptions(){
    if(!this.searchTerm){
      return this.medicineprescriptionService.medicineprescription;
    }
  


  //2. Return filteredmedicine prescriptionList
  const searchTermLower= this.searchTerm.toLowerCase();

  return this.medicineprescriptionService.medicineprescription.filter(e =>
  {
    const medCode = `p${e.PrescriptionId}`.toLowerCase()
    return(
    e.MedicineName?.toLowerCase().includes(searchTermLower) ||
    medCode.includes(searchTermLower)
  );
});



  }
  medicineDis(prescribedmedicine:any){
      this.medicinedistributeService.formMedicinedistributeData = Object.assign({},prescribedmedicine)
      this.router.navigate(['/medicine-prescriptions/Medicinedistributeadd',prescribedmedicine.PrescriptionId])
  }
}



