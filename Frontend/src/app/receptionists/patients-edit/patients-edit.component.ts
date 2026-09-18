import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { PatientService } from 'src/app/shared/service/patient.service';

@Component({
  selector: 'app-patients-edit',
  templateUrl: './patients-edit.component.html',
  styleUrls: ['./patients-edit.component.scss']
})
export class PatientsEditComponent implements OnInit {
   //declare variable
   errorMessage: string | null = null;
   todayDate: string = new Date().toISOString().split('T')[0]; // Format as 'yyyy-MM-dd'

  constructor(public patientService: PatientService,
    private router: Router, 
    private toastr: ToastrService) { }

    //Submit Form
  onSubmit(patform: NgForm) {
    console.log(patform.value);

    //call Insert  Method
    if (patform.valid) {
      this.updatePatient(patform);
    }

    //Redirect to Employee List
    this.router.navigate(['/patients/list'])

    //Reset form
    patform.reset();

  }

  //Update method
  updatePatient(patform: NgForm) {
    console.log("updating...")
    this.patientService.updatePatient(patform.value).subscribe(
      (response) => {
        console.log(response);
        this.toastr.success('Record has been updated successfully', 'CMS v2024')

        //Insert successful, clear error message
        this.errorMessage = null;

        //Refresh the list and navigate to the employee list page
        this.patientService.getAllPatients();

        //Redirect to Employee List
        this.router.navigate(['/patients/list'])

        //Reset form
        patform.reset();
      },
      (error) => {
        console.log(error);
        this.toastr.error('An error occured !.. try again..', 'EMS v2024')
        this.errorMessage = 'An error occured' + error;
      }
    )
  };

  ngOnInit(): void { }

}
