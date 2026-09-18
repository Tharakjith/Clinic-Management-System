import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MedicineListComponent } from './medicine-list/medicine-list.component';
import { MedicineAddComponent } from './medicine-add/medicine-add.component';
import { MedicineEditComponent } from './medicine-edit/medicine-edit.component';

const routes: Routes = [
  //medicine-list
  {path:'list', component: MedicineListComponent},

  //medicine-add
  {path:'add', component: MedicineAddComponent},

  //medicine-edit
  {path:'edit/:id', component: MedicineEditComponent},
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MedicineManagementsRoutingModule { }
