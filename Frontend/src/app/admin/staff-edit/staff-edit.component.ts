import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { StaffService } from 'src/app/shared/service/staff.service';

@Component({
  selector: 'app-staff-edit',
  templateUrl: './staff-edit.component.html',
  styleUrls: ['./staff-edit.component.scss']
})
export class StaffEditComponent implements OnInit {

 //declare variable
 errorMessage: string |null=null;
 constructor(public staffService:StaffService,
   private router:Router,private toastr: ToastrService) { }


 //SubmitForm

 onSubmit(stForm: NgForm){
   console.log(stForm.value);

 //Call Insert Method
this.UpdateStaffs(stForm);

}

//Insert Method
UpdateStaffs(stForm: NgForm){
 console.log("inserting...");
 this.staffService.UpdateStaffs(stForm.value).subscribe(
   (response)=>{
     console.log(response);
     this.toastr.success('Record has been deleted successfully','EMS v2024');
 
     //insert successfull ,clear error message
     this.errorMessage = null;
 
     //refresh the list anf navigate to the employee list page
     this.staffService.getAllStaffs();
 
     //Redirect to employeee List
     this.router.navigate(['/admin/list']);
     //Reset Form
     stForm.reset();
 
   },
   (error)=>{
     console.log(error);
     this.toastr.error('An error occurred ','CMS v2024');
     this.errorMessage ='An error occured!' + error;
   }
 );
 }

 ngOnInit(): void {
   //get all departments
   this.staffService.getAllDepartments();
 }
}
