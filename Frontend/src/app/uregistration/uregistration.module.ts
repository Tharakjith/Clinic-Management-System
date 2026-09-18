import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UregistrationRoutingModule } from './uregistration-routing.module';
import { UregistrationComponent } from './uregistration.component';
import { UregistrationListComponent } from './uregistration-list/uregistration-list.component';
import { UregistrationEditComponent } from './uregistration-edit/uregistration-edit.component';
import { UregistrationAddComponent } from './uregistration-add/uregistration-add.component';
import { FormsModule } from '@angular/forms';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { NgxPaginationModule } from 'ngx-pagination';


@NgModule({
  declarations: [
    UregistrationComponent,
    UregistrationListComponent,
    UregistrationEditComponent,
    UregistrationAddComponent
  ],
  imports: [
    CommonModule,
    UregistrationRoutingModule,
    NgxPaginationModule,
    Ng2SearchPipeModule,
    FormsModule  
  ]
})
export class UregistrationModule { }