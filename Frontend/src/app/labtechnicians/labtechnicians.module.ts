import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LabtechniciansRoutingModule } from './labtechnicians-routing.module';
import { LabtechniciansComponent } from './labtechnicians.component';
import { LabtestlistListComponent } from './labtestlist-list/labtestlist-list.component';
import { LabtestreportUpdateComponent } from './labtestreport-update/labtestreport-update.component';
import { LabtestbillListComponent } from './labtestbill-list/labtestbill-list.component';


@NgModule({
  declarations: [
    LabtechniciansComponent,
    LabtestlistListComponent,
    LabtestreportUpdateComponent,
    LabtestbillListComponent
  ],
  imports: [
    CommonModule,
    LabtechniciansRoutingModule
  ]
})
export class LabtechniciansModule { }
