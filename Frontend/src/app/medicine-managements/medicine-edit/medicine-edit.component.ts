import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MedicinedetailsService } from 'src/app/shared/service/medicinedetails.service';

@Component({
  selector: 'app-medicine-edit',
  templateUrl: './medicine-edit.component.html',
  styleUrls: ['./medicine-edit.component.scss']
})
export class MedicineEditComponent implements OnInit {

//declare variables
errorMessage: string | null = null;

constructor(public medicineDetailsService: MedicinedetailsService,
  private router : Router,private toastr: ToastrService) { }

ngOnInit(): void {
  //get all departments
  this.medicineDetailsService.getAllCategory();
}
//SubmitForm

onSubmit(medForm: NgForm){
  console.log(medForm.value);

//Call Insert Method
this.UpdateMedicineDetails(medForm);

}

//Insert Method
UpdateMedicineDetails(medForm: NgForm){
console.log("inserting...");
this.medicineDetailsService.updateMedicineDetails(medForm.value).subscribe(
  (response)=>{
    console.log(response);
    this.toastr.success('Record has been deleted successfully','EMS v2024');

    //insert successfull ,clear error message
    this.errorMessage = null;

    //refresh the list anf navigate to the employee list page
    this.medicineDetailsService.getAllMedicineDetails();

    //Redirect to employeee List
    this.router.navigate(['/medicine/list']);
    //Reset Form
    medForm.reset();

  },
  (error)=>{
    console.log(error);
    this.toastr.error('An error occurred ','EMS v2024');
    this.errorMessage ='An error occured!' + error;
  }
);
}
}


