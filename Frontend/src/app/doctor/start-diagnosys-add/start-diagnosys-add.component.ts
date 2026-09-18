import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { DoctorService } from 'src/app/shared/service/doctor.service';

@Component({
  selector: 'app-start-diagnosys-add',
  templateUrl: './start-diagnosys-add.component.html',
  styleUrls: ['./start-diagnosys-add.component.scss']
})

export class StartDiagnosysAddComponent implements OnInit {
  
  //declare error message
  errorMessage:string |null=null;

  constructor(public doctorService:DoctorService,
    private router:Router,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
   
    this.doctorService.getAllDoctors();
  }
  //Submit form
  onSubmit(empform:NgForm){
    console.log(empform.value);
    //call insert method
    this.addDiagnosys(empform);
    //Reset Form
   empform.reset();

    //Redirect to Employee List
    this.router.navigate(['/doctor/startdiagnosys/add']);

  }
  //Insert Method
  addDiagnosys(empform:NgForm){
    console.log("inserting...");
    this.doctorService.insertDiagnosys(empform.value).subscribe(
      (response)=>{
        console.log(response);
        this.toastr.success('Record has been inserted successfully','EMSv2024')
        this.errorMessage=null;
        this.doctorService.getAllDiagnosys();

        this.router.navigate(['/doctor/startdiagnosys/list']);

        empform.reset()

      },
      (error)=>{
        console.log(error);
        this.toastr.error('An error Occured','EMSv2024')
        this.errorMessage='An error Occured' + error;
      }
    );
  }

}
