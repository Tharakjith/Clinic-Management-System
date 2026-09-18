import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { PatientService } from 'src/app/shared/service/patient.service';

@Component({
  selector: 'app-patients-add',
  templateUrl: './patients-add.component.html',
  styleUrls: ['./patients-add.component.scss']
})
export class PatientsAddComponent implements OnInit {

  //declare variable
  errorMessage: string | null = null;

  constructor(public patientService: PatientService,
    private router: Router, 
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {}

  //Submit Form
  onSubmit(patform: NgForm) {
    console.log('Form Values Submitted:', patform.value);

    //call Insert  Method
    this.addPatient(patform);

    //this.router.navigate(['/patients/list'])

    patform.reset();

  }

  //Insert Method
  addPatient(patform: NgForm) {
    console.log("Inserting Patient...")
    this.patientService.insertPatient(patform.value).subscribe(
      (response) => {
        console.log('Response from Server:',response);
        this.toastr.success('Record has been inserted successfully','CMS v2024')

        //Insert successful, clear error message
        this.errorMessage = null;

        //this.patientService.getAllPatients();

        // Redirect to book appointment page
      this.router.navigate(['/patients/list', response.PatientId]);

        //this.router.navigate(['/patients/list'])
        //patform.reset();
      },
      (error) => {
        console.log(error);
        this.toastr.error('An error occured !.. try again..', 'CMS v2024')
        this.errorMessage = 'An error occured' + error;
      }
    )
  };

}
