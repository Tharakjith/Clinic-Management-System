import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Registration } from 'src/app/shared/model/registration';
import { RegistrationService } from 'src/app/shared/service/registration.service';

@Component({
  selector: 'app-uregistration-add',
  templateUrl: './uregistration-add.component.html',
  styleUrls: ['./uregistration-add.component.scss']
})
export class UregistrationAddComponent implements OnInit {

  errorMessage: string | null = null;
  showPassword: boolean = false;

  constructor(
    public registrationService: RegistrationService,
    private router: Router,
    private toastr: ToastrService
  ) {}

  togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }

  ngOnInit(): void {
    this.registrationService.getAllRoles();
    this.registrationService.getAllStaffs();
  }

  // Submit form
  onSubmit(stForm: NgForm): void {
    console.log(stForm.value);
    // Call insert method
    this.insertUsers(stForm);
  }

  // Insert method
  insertUsers(stForm: NgForm): void {
    console.log("Inserting staff add");
    this.registrationService.insertUsers(stForm.value).subscribe(
      (response) => {
        console.log(response);
        this.toastr.success('User registered successfully', 'CMS');

        // Clear error message after successful insertion
        this.errorMessage = null;

        // Fetch updated users and navigate to the list
        this.registrationService.getAllusers();
        this.router.navigate(['/uregistration/list']);
        stForm.reset();
      },
      (error)=>{
        console.log(error);
        this.toastr.error('An error occurred ','CMS v2025');
        this.errorMessage ='An error occurred ' +error;
   
       
      }
    );
  }
}