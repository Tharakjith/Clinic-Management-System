import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DoctormgmtRoutingModule } from './doctormgmt-routing.module';
import { DoctormgmtComponent } from './doctormgmt.component';
import { DoctormgmtListComponent } from './doctormgmt-list/doctormgmt-list.component';
import { DoctormgmtEditComponent } from './doctormgmt-edit/doctormgmt-edit.component';
import { DoctormgmtAddComponent } from './doctormgmt-add/doctormgmt-add.component';
import { NgxPaginationModule } from 'ngx-pagination';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    DoctormgmtComponent,
    DoctormgmtListComponent,
    DoctormgmtEditComponent,
    DoctormgmtAddComponent
  ],
  imports: [
    CommonModule,
    DoctormgmtRoutingModule,
    NgxPaginationModule,
        Ng2SearchPipeModule,
        FormsModule  
  ]
})
export class DoctormgmtModule { }