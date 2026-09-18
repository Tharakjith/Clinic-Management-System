import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MedicinedetailsService } from 'src/app/shared/service/medicinedetails.service';

@Component({
  selector: 'app-medicine-add',
  templateUrl: './medicine-add.component.html',
  styleUrls: ['./medicine-add.component.scss']
})
export class MedicineAddComponent implements OnInit {

  //declare variables
  errorMessage: string | null = null;

   constructor(public medicineDetailsService: MedicinedetailsService,
    private router : Router,private toastr: ToastrService) { }

  ngOnInit(): void {
    
  }

//SubmitForm

onSubmit(medForm: NgForm){
  console.log(medForm.value);

   //Call Insert Method
    this.addMedicine(medForm);

   //Reset Form
   medForm.reset();

   //Redirect to Employee List
 this.router.navigate(['/medicine-managements/list']);


}

  //Insert Method
  addMedicine(medForm: NgForm){
  console.log("inserting...");
  this.medicineDetailsService.insertMedicineDetails(medForm.value).subscribe(
    (response)=>{
      console.log(response);
      this.toastr.success('Record has been inserted successfully','EMSv2024');

  //insert successfull ,clear error message
  this.errorMessage = null;

  //refresh the list anf navigate to the medicine list page
  this.medicineDetailsService.getAllMedicineDetails();

  //Redirect to medicine List
  this.router.navigate(['/medicine-managements/list']);
  //Reset Form
   medForm.reset();

  },
    (error)=>{
      console.log(error);
      this.toastr.error('An error occurred ','EMSv2024');
      this.errorMessage ='An error occured!' + error;
  }
);
}
}
