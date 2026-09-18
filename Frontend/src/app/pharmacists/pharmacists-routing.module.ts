import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MedicineprescriptionListComponent } from './medicineprescription-list/medicineprescription-list.component';
import { MedicinedistributeAddComponent } from './medicinedistribute-add/medicinedistribute-add.component';
import { MedicinebillListComponent } from './medicinebill-list/medicinebill-list.component';

const routes: Routes = [

  //employee-list
  {path:'Medicineprescriptionlist', component: MedicineprescriptionListComponent},
  {path:'Medicinedistributeadd/:id', component: MedicinedistributeAddComponent},
  {path:'Medicinebilllist', component: MedicinebillListComponent},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PharmacistsRoutingModule { }
