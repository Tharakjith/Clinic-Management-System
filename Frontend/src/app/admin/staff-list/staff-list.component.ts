import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Staff } from 'src/app/shared/model/staff';
import { StaffService } from 'src/app/shared/service/staff.service';

@Component({
  selector: 'app-staff-list',
  templateUrl: './staff-list.component.html',
  styleUrls: ['./staff-list.component.scss']
})
export class StaffListComponent implements OnInit {
  // Pagination variables
  page: number = 1;
  pageSize: number = 3;

  // Search term
  searchTerm: string = '';

  constructor(
    public staffService: StaffService,
    private router: Router,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    console.log('Hi, I am the staff list component.');
    this.staffService.getAllStaffs();
  }

  // Filter staff based on search term
  filteredStaffs() {
    if (!this.searchTerm) {
      return this.staffService.staffs;
    }
    const searchTermLower = this.searchTerm.toLowerCase();
    return this.staffService.staffs.filter(staff => {
      const staffCode = `ST${staff.StaffId}`.toLowerCase();
      return (
        staff.PhoneNumber?.toLowerCase().includes(searchTermLower) ||
        staffCode.includes(searchTermLower)
      );
    });
  }

  UpdateStaffs(staff:Staff):void{
    console.log(staff);
    this.populateStaffData(staff);
    this.router.navigate(['/admin/edit/'+staff.StaffId]);
    //Call Populate Employee
  }

  // Populate staff data for update
  populateStaffData(staff: Staff): void {
    console.log('Inside populateStaffData method');
    console.log(staff);

    // Transform date format to YYYY-MM-DD using DatePipe
    var datePipe = new DatePipe('en-UK');
    let formattedDate: any= datePipe.transform(staff.Dob, 'yyyy-MM-dd');
   
    staff.Dob = formattedDate ; // Fallback to empty string if null
    this.staffService.formStaffData = { ...staff };
  }

  // Delete staff record
  deleteStaff(staff: Staff): void {
    if (confirm(`Are you sure you want to delete staff '${staff.StaffName}'?`)) {
      this.staffService.deleteStaff(staff.StaffId).subscribe(
        response => {
          this.toastr.success('Staff member has been deleted successfully', 'CMS');
          // Instantly erase row from the view
          this.staffService.staffs = this.staffService.staffs.filter(s => s.StaffId !== staff.StaffId);
        },
        error => {
          console.error(error);
          this.toastr.error('Failed to delete staff member.', 'CMS');
        }
      );
    }
  }
}
