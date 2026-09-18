import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { LabtestService } from 'src/app/shared/service/labtest.service';
@Component({
  selector: 'app-lab-add',
  templateUrl: './lab-add.component.html',
  styleUrls: ['./lab-add.component.scss']
})
export class LabAddComponent implements OnInit {
  errorMessage: string |null=null;
  constructor(public labService:LabtestService,
    private router:Router,private toastr: ToastrService) { }

  ngOnInit(): void {
    
  }
//submit form
onSubmit(stForm: NgForm){
  console.log(stForm.value);

  //Call insert method
this.addStaff(stForm);
  //Reset Form
  this.router.navigate(['/lab/list'])
  stForm.reset();

  
}
//Insert method
addStaff(stForm:NgForm){
  console.log("Inserting staff add");
  this.labService.inserttests(stForm.value).subscribe(
    (response)=>{
      console.log(response);
      this.toastr.success('The record has been successfully inserted','CMS v2025');
     

      //Insert successful clear error message
      this.errorMessage=null;
      this.labService.getAlltests();
      this.router.navigate(['/lab/list'])
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



