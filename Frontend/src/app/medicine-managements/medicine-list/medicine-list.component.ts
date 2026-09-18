import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Medicinedetails } from 'src/app/shared/model/medicinedetails';
import { MedicinedetailsService } from 'src/app/shared/service/medicinedetails.service';

@Component({
  selector: 'app-medicine-list',
  templateUrl: './medicine-list.component.html',
  styleUrls: ['./medicine-list.component.scss']
})
export class MedicineListComponent implements OnInit {


  //declare variables
  page: number=1;
  pageSize: number=5;
  searchTerm: string='';

  constructor(public medicineDetailsService: MedicinedetailsService,
    private router : Router,private toastr: ToastrService) { }

  //Life Cycle hook
  ngOnInit(): void {
    console.log("hi I am medicine List Component");
    this.medicineDetailsService.getAllMedicineDetails();
    
      this.medicineDetailsService.getAllCategory(); // Fetch categories
    
  }

  getCategoryName(categoryId: number): string {
    const category = this.medicineDetailsService.category.find(c => c.CategoryId === categoryId);
    return category ? category.CategoryName : 'Unknown';
  }

  //Search Method
filteredMedicineDetails(){
  if(!this.searchTerm){
    return this.medicineDetailsService.medicineDetails;
  }


  //2. Return filteredMedicineDetailsList
  const searchTermLower= this.searchTerm.toLowerCase();

  return this.medicineDetailsService.medicineDetails.filter(p =>
  {
    const medCode = `ep${p.MedicineId}`.toLowerCase()
    return(
    p.MedicineName?.toLowerCase().includes(searchTermLower) ||
    medCode.includes(searchTermLower)
  );
});
}
//Edit Medicine
editMedicineDetails(medicineDetail : Medicinedetails):void{
  console.log(medicineDetail);

  //Call populate Medicine Method
  this.populateMedicineDetailsData(medicineDetail);
  //routw to edit componenet
  this.router.navigate(['/medicine-managements/edit/' + medicineDetail.MedicineId]);

}
// Getting Medicine for populating Medicine Data
populateMedicineDetailsData(medicineDetail : Medicinedetails){
  console.log("In side populate method");

  console.log(medicineDetail);
  //Transform Date Format as yyyy-MM-dd
  var datePipe =  new DatePipe("en-UK");

let formattedManufacturingDate: any = datePipe.transform(medicineDetail.ManufacturingDate, 'dd-MM-yyyy');
let formattedExpiryDate: any = datePipe.transform(medicineDetail.ExpiryDate, 'dd-MM-yyyy');

  this.medicineDetailsService.ManufacturingDate= formattedManufacturingDate;
  this.medicineDetailsService.ExpiryDate= formattedExpiryDate;
  this.medicineDetailsService.formMedicineDetailsData={...medicineDetail};

}

//Delete Medicine
deleteMedicineDetails(medicineDetail: Medicinedetails){
  if(confirm(`Are you sure you want to delete medicine '${medicineDetail.MedicineName}'?`)){
    this.medicineDetailsService.deleteMedicine(medicineDetail.MedicineId).subscribe(
      (response)=>{
        this.toastr.success('Medicine has been deleted successfully','CMS');
        // Instantly erase row from view
        this.medicineDetailsService.medicineDetails = this.medicineDetailsService.medicineDetails.filter(
          m => m.MedicineId !== medicineDetail.MedicineId
        );
      },
      (error)=>{
        console.error(error);
        this.toastr.error('Failed to delete medicine record.','CMS');
      }
    );
  }
}
}

