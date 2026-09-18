import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Registration } from 'src/app/shared/model/registration';
import { RegistrationService } from 'src/app/shared/service/registration.service';

@Component({
  selector: 'app-uregistration-list',
  templateUrl: './uregistration-list.component.html',
  styleUrls: ['./uregistration-list.component.scss']
})
export class UregistrationListComponent implements OnInit {

  page: number = 1;
  pageSize: number = 10;
  searchTerm: string = '';

  constructor(
    public registerService: RegistrationService,
    private router: Router,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    this.registerService.getAllusers();
    this.registerService.getAllRoles();
  }

  getRoleName(roleId: number): string {
    const Role = this.registerService.role.find(c => c.RoleId === roleId);
    return Role ? Role.RoleName : '';
  }

  filteredUsers(): Registration[] {
    if (!this.searchTerm) {
      return this.registerService.registration;
    }
    const term = this.searchTerm.toLowerCase();
    return this.registerService.registration.filter(reg =>
      reg.Staff?.StaffName?.toLowerCase().includes(term) ||
      reg.Username?.toLowerCase().includes(term) ||
      reg.Role?.RoleName?.toLowerCase().includes(term)
    );
  }

  Updateusers(register: Registration): void {
    this.populatedoctorData(register);
    this.router.navigate(['/uregistration/edit/' + register.RegistrationId]);
  }

  // Populate staff data for update
  populatedoctorData(register: Registration): void {
    this.registerService.formStaffData = { ...register };
  }

  deleteUser(register: Registration) {
    if (confirm(`Are you sure you want to permanently delete user '${register.Username}'?`)) {
      this.registerService.deleteUser(register.RegistrationId).subscribe(
        (response) => {
          this.toastr.success('User has been deleted successfully', 'CMS');
          // Instantly erase row from view
          this.registerService.registration = this.registerService.registration.filter(
            u => u.RegistrationId !== register.RegistrationId
          );
        },
        (error) => {
          console.error(error);
          this.toastr.error('Failed to delete user. Please try again.', 'CMS');
        }
      );
    }
  }
}