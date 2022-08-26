import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AgregarComponent } from './components/agregar/agregar.component';
import { AgriculturaComponent } from './components/agricultura/agricultura.component';
import { NosotrosComponent } from './components/nosotros/nosotros.component';
import { PresentacionComponent } from './components/presentacion/presentacion.component';

const routes: Routes = [
  { path: 'agricultura', component: AgriculturaComponent },
  { path: 'nosotros', component: NosotrosComponent },
  { path: 'agregar', component: AgregarComponent },
  { path: 'presentacion', component: PresentacionComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
