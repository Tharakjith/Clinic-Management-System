import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { RegistrationService } from 'src/app/shared/service/registration.service';

@Component({
  selector: 'app-uregistration-edit',
  templateUrl: './uregistration-edit.component.html',
  styleUrls: ['./uregistration-edit.component.scss']
})
export class UregistrationEditComponent implements OnInit {

  errorMessage: string | null = null;
  showPassword: boolean = false;

  constructor(
    public registrationService: RegistrationService,
    private router: Router,
    private toastr: ToastrService
  ) { }

  togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }

  // SubmitForm
  onSubmit(stForm: NgForm) {
    console.log(stForm.value);
    this.Updateusers(stForm);
  }

  // Update Method
  Updateusers(stForm: NgForm) {
    console.log("Updating user...");
    this.registrationService.Updateusers(stForm.value).subscribe(
      (response) => {
        console.log(response);
        this.toastr.success('User updated successfully', 'CMS');

        // Clear error message
        this.errorMessage = null;

        // Refresh users list and navigate
        this.registrationService.getAllusers();
        this.router.navigate(['/uregistration/list']);
        stForm.reset();
      },
      (error) => {
        console.log(error);
        this.toastr.error('An error occurred while updating user', 'CMS');
        this.errorMessage = 'An error occurred: ' + error;
      }
    );
  }

  ngOnInit(): void {
    this.registrationService.getAllusers();
    this.registrationService.getAllRoles();
  }
}