import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { DmanagementService } from 'src/app/shared/service/dmanagement.service';

@Component({
  selector: 'app-doctormgmt-add',
  templateUrl: './doctormgmt-add.component.html',
  styleUrls: ['./doctormgmt-add.component.scss']
})
export class DoctormgmtAddComponent implements OnInit {

  errorMessage: string | null = null;

  constructor(
    public doctormanagementService: DmanagementService,
    private router: Router,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    this.doctormanagementService.formStaffData = {
      DoctorId: 0,
      RegistrationId: 0,
      StaffId: 0,
      SpecializationId: 0,
      ConsultationFee: 500,
      DoctorIsActive: true,
      Staff: {} as any,
      Registration: {} as any,
      Specialization: {} as any
    };
    this.doctormanagementService.getAlldoctors();
    this.doctormanagementService.getAllSpecilization();
    this.doctormanagementService.getAllstaff();
    this.doctormanagementService.getAllusers();
  }

  // Filter staff to show ONLY doctors (DepartmentId === 2 or Doctor role)
  get doctorStaffList() {
    const seen = new Set<string>();
    return this.doctormanagementService.staff.filter(s => {
      const isDoctor = s.DepartmentId === 2;
      if (isDoctor && !seen.has(s.StaffName.toLowerCase())) {
        seen.add(s.StaffName.toLowerCase());
        return true;
      }
      return false;
    });
  }

  onDoctorSelected(event: any): void {
    const staffId = +event.target.value;
    const staff = this.doctormanagementService.staff.find(s => s.StaffId === staffId);
    if (staff) {
      const user = this.doctormanagementService.registration.find(
        u => u.StaffId === staffId || (u.RoleId === 2 && u.Username.toLowerCase() === staff.StaffName.toLowerCase())
      );
      if (user) {
        this.doctormanagementService.formStaffData.RegistrationId = user.RegistrationId;
      }
    }
  }

  // Submit form
  onSubmit(stForm: NgForm) {
    console.log(stForm.value);
    this.adddoctor(stForm);
  }

  // Insert method
  adddoctor(stForm: NgForm) {
    console.log("Attempting to add doctor");

    const payload = {
      DoctorId: 0,
      StaffId: +this.doctormanagementService.formStaffData.StaffId,
      SpecializationId: +this.doctormanagementService.formStaffData.SpecializationId,
      ConsultationFee: +this.doctormanagementService.formStaffData.ConsultationFee,
      DoctorIsActive: this.doctormanagementService.formStaffData.DoctorIsActive,
      RegistrationId: this.doctormanagementService.formStaffData.RegistrationId || +this.doctormanagementService.formStaffData.StaffId
    };

    this.doctormanagementService.insertdoctors(payload as any).subscribe(
      (response) => {
        if (response) {
          this.toastr.success('Doctor successfully registered.', 'CMS');
          this.errorMessage = null;
          this.doctormanagementService.getAlldoctors();
          this.router.navigate(['/doctormgmt/list']);
          stForm.reset();
        }
      },
      (error) => {
        console.log(error);
        this.toastr.error('Failed to add doctor record', 'CMS');
        this.errorMessage = 'An error occurred: ' + (error?.message || error);
      }
    );
  }
}