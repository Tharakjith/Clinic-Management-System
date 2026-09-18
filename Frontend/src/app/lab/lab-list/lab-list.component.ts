import { Component, OnInit } from '@angular/core';
import { DatePipe } from '@angular/common';

import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { LabtestService } from 'src/app/shared/service/labtest.service';
import { Labtest } from 'src/app/shared/model/labtest';
@Component({
  selector: 'app-lab-list',
  templateUrl: './lab-list.component.html',
  styleUrls: ['./lab-list.component.scss']
})
export class LabListComponent implements OnInit {
   //Pagination variables
  page: number = 1;
  pageSize: number = 3;

  // Search term
  searchTerm: string = '';

  constructor(
    public labService: LabtestService,
    private router: Router,
    private toastr: ToastrService
  ) {}
  ngOnInit(): void {
    console.log('Hi, I am the staff list component.');
    this.labService.getAlltests();
  }

  // Filter staff based on search term
  filteredtests() {
    if (!this.searchTerm) {
      return this.labService.labs;
    }
    const searchTermLower = this.searchTerm.toLowerCase();
    return this.labService.labs.filter(labs => {
      const staffCode = `LT${labs.LabTestId}`.toLowerCase();
      return (
        labs.TestName?.toLowerCase().includes(searchTermLower) ||
        staffCode.includes(searchTermLower)
      );
    });
  }

  Updatetests(labs:Labtest):void{
    console.log(labs);
    this.populateStaffData(labs);
    this.router.navigate(['/lab/edit/'+labs.LabTestId]);
    //Call Populate Employee
  }

  // Populate staff data for update
  populateStaffData(labs: Labtest): void {
    console.log('Inside populateStaffData method');
    console.log(labs);

    // Transform date format to YYYY-MM-DD using DatePipe
    var datePipe = new DatePipe('en-UK');
    let formattedDate: any= datePipe.transform(labs.CreatedDate, 'yyyy-MM-dd');
   
    labs.CreatedDate = formattedDate ; // Fallback to empty string if null
    this.labService.formlabData = { ...labs };
  }

  // Delete lab test record
  deleteStaff(labs: Labtest): void {
    if (confirm(`Are you sure you want to delete test '${labs.TestName}'?`)) {
      this.labService.deleteTest(labs.LabTestId).subscribe(
        response => {
          this.toastr.success('Lab test has been deleted successfully', 'CMS');
          // Instantly erase row from table
          this.labService.labs = this.labService.labs.filter(l => l.LabTestId !== labs.LabTestId);
        },
        error => {
          console.error(error);
          this.toastr.error('Failed to delete lab test.', 'CMS');
        }
      );
    }
  }
}




