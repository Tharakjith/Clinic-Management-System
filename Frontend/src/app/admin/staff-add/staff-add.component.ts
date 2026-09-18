import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { StaffService } from 'src/app/shared/service/staff.service';

@Component({
  selector: 'app-staff-add',
  templateUrl: './staff-add.component.html',
  styleUrls: ['./staff-add.component.scss']
})
export class StaffAddComponent implements OnInit {
  errorMessage: string |null=null;
  constructor(public staffService:StaffService,
    private router:Router,private toastr: ToastrService) { }

  ngOnInit(): void {
    this.staffService.getAllDepartments();
  }
//submit form
onSubmit(stForm: NgForm){
  console.log(stForm.value);

  //Call insert method
this.addStaff(stForm);
  //Reset Form
  this.router.navigate(['/admin/list'])
  stForm.reset();

  
}
//Insert method
addStaff(stForm:NgForm){
  console.log("Inserting staff add");
  this.staffService.insertStaffs(stForm.value).subscribe(
    (response)=>{
      console.log(response);
      this.toastr.success('The record has been successfully inserted','CMS v2025');
     

      //Insert successful clear error message
      this.errorMessage=null;
      this.staffService.getAllStaffs();
      this.router.navigate(['/admin/list'])
  stForm.reset();
    },
    (error)=>{
      console.log(error);
      this.toastr.error('An error occurred ','CMS v2025');
      this.errorMessage ='An error occurred ' +error;
 
     
    }
  )
};
}



