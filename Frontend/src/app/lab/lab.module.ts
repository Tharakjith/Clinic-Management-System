import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LabRoutingModule } from './lab-routing.module';
import { LabComponent } from './lab.component';
import { LabListComponent } from './lab-list/lab-list.component';
import { LabAddComponent } from './lab-add/lab-add.component';
import { LabEditComponent } from './lab-edit/lab-edit.component';
import { LabRequestsComponent } from './lab-requests/lab-requests.component';
import { NgxPaginationModule } from 'ngx-pagination';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    LabComponent,
    LabListComponent,
    LabAddComponent,
    LabEditComponent,
    LabRequestsComponent
  ],
  imports: [
  CommonModule,
      LabRoutingModule,
      NgxPaginationModule,
      Ng2SearchPipeModule,
      FormsModule  
  ]
})
export class LabModule { }
