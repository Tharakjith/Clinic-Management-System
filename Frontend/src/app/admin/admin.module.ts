import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';
import { StaffListComponent } from './staff-list/staff-list.component';
import { StaffAddComponent } from './staff-add/staff-add.component';
import { StaffEditComponent } from './staff-edit/staff-edit.component';

import { NgxPaginationModule } from 'ngx-pagination';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    AdminComponent,
    StaffListComponent,
    StaffAddComponent,
    StaffEditComponent,
   
   
  ],
  imports: [
    CommonModule,
    AdminRoutingModule,
    NgxPaginationModule,
    Ng2SearchPipeModule,
    FormsModule  
  ]
})
export class AdminModule { }
