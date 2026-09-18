import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AuthService } from 'src/app/shared/service/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  loginForm!: FormGroup;
  isSubmitted: boolean = false;
  isLoading: boolean = false;
  error: string = '';
  showPassword: boolean = false;
  returnUrl: string = '';

  constructor(
    private formBuilder: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    // Check if user is already logged in
    if (this.authService.isAuthenticated()) {
      this.redirectByRole(this.authService.getRoleId());
    }

    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '';

    // Create Reactive form
    this.loginForm = this.formBuilder.group({
      Username: ['', [Validators.required]],
      Password: ['', [Validators.required]]
    });
  }

  togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }

  // Get all controls for validation
  get formControls() {
    return this.loginForm.controls;
  }

  // Submit credentials via secure POST
  loginCredentials(): void {
    this.isSubmitted = true;
    if (this.loginForm.invalid) {
      this.toastr.error('Please enter both username and password.', 'Validation Error');
      this.error = 'Please enter both username and password.';
      return;
    }

    this.error = '';
    this.isLoading = true;

    this.authService.loginVerify(this.loginForm.value)
      .subscribe({
        next: (response: any) => {
          this.isLoading = false;
          const roleId = Number(response.RoleId ?? response.roleId);
          const username = response.Username ?? response.username;

          this.toastr.success(`Welcome back, ${username}!`, 'Login Successful');

          if (this.returnUrl) {
            this.router.navigateByUrl(this.returnUrl);
          } else {
            this.redirectByRole(roleId);
          }
        },
        error: (err: any) => {
          this.isLoading = false;
          console.error('Login failed:', err);
          const msg = err.error?.message || 'Invalid username or password. Please try again.';
          this.error = msg;
          this.toastr.error(msg, 'Authentication Failed');
        }
      });
  }

  private redirectByRole(roleId: number): void {
    // 1 = Admin, 2 = Doctor, 3 = Receptionist, 4 = Pharmacist, 5 = Lab Technician
    switch (roleId) {
      case 1:
        this.router.navigate(['auth/admin']);
        break;
      case 2:
        this.router.navigate(['auth/doctor']);
        break;
      case 3:
        this.router.navigate(['auth/receptionist']);
        break;
      case 4:
        this.router.navigate(['auth/pharmacists']);
        break;
      case 5:
        this.router.navigate(['auth/labtechnician']);
        break;
      default:
        this.error = 'Unrecognized role assigned. Please contact the administrator.';
        this.toastr.warning(this.error, 'Access Restricted');
        this.authService.logOutRemoveItems();
    }
  }
}
