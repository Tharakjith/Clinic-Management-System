import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { LabtestService } from 'src/app/shared/service/labtest.service';
@Component({
  selector: 'app-lab-edit',
  templateUrl: './lab-edit.component.html',
  styleUrls: ['./lab-edit.component.scss']
})
export class LabEditComponent implements OnInit {

  errorMessage: string |null=null;
 constructor(public labService:LabtestService,
   private router:Router,private toastr: ToastrService) { }
  ngOnInit(): void {
    if (!this.labService.formlabData || !this.labService.formlabData.LabTestId) {
      this.labService.getAlltests();
    }
  }

  onSubmit(stForm: NgForm) {
    if (stForm.invalid) {
      return;
    }
    this.Updatetests(stForm);
  }

  // Update Method
  Updatetests(stForm: NgForm) {
    console.log("Updating lab test...", stForm.value);
    this.labService.Updatetests(stForm.value).subscribe(
      (response) => {
        this.toastr.success('Lab test updated successfully', 'CMS');
        this.errorMessage = null;
        this.labService.getAlltests();
        this.router.navigate(['/lab/list']);
        stForm.reset();
      },
      (error) => {
        console.error(error);
        this.toastr.error('An error occurred while updating lab test', 'CMS');
        this.errorMessage = 'An error occurred: ' + error;
      }
    );
  }
 
  
 }
 
