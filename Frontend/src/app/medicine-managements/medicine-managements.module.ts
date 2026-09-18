import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MedicineManagementsRoutingModule } from './medicine-managements-routing.module';
import { MedicineManagementsComponent } from './medicine-managements.component';
import { MedicineListComponent } from './medicine-list/medicine-list.component';
import { MedicineAddComponent } from './medicine-add/medicine-add.component';
import { MedicineEditComponent } from './medicine-edit/medicine-edit.component';
import { FormsModule } from '@angular/forms';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { NgxPaginationModule } from 'ngx-pagination';


@NgModule({
  declarations: [
    MedicineManagementsComponent,
    MedicineListComponent,
    MedicineAddComponent,
    MedicineEditComponent
  ],
  imports: [
    CommonModule,
    MedicineManagementsRoutingModule,
    NgxPaginationModule,
    Ng2SearchPipeModule,
    FormsModule
  ]
})
export class MedicineManagementsModule { }
