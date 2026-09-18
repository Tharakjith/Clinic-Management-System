import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { DmanagementService } from 'src/app/shared/service/dmanagement.service';

@Component({
  selector: 'app-doctormgmt-edit',
  templateUrl: './doctormgmt-edit.component.html',
  styleUrls: ['./doctormgmt-edit.component.scss']
})
export class DoctormgmtEditComponent implements OnInit {

  errorMessage: string | null = null;

  constructor(
    public doctormanagementService: DmanagementService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService
  ) { }

  ngOnInit(): void {
    this.doctormanagementService.getAllSpecilization();
    this.doctormanagementService.getAllstaff();
    this.doctormanagementService.getAllusers();
  }

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

  onSubmit(stForm: NgForm): void {
    if (stForm.invalid) {
      return;
    }

    this.doctormanagementService.Updateusers(this.doctormanagementService.formStaffData).subscribe(
      (response) => {
        this.toastr.success('Doctor details updated successfully.', 'CMS');
        this.errorMessage = null;
        this.doctormanagementService.getAlldoctors();
        this.router.navigate(['/doctormgmt/list']);
      },
      (error) => {
        console.error('Error updating doctor:', error);
        this.toastr.error('An error occurred while updating doctor', 'CMS');
        this.errorMessage = 'An error occurred: ' + (error?.message || error);
      }
    );
  }

}
