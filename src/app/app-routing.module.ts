import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AgriculturaComponent } from './components/agricultura/agricultura.component';
import { NosotrosComponent } from './components/nosotros/nosotros.component';

const routes: Routes = [
  { path: 'agricultura', component: AgriculturaComponent },
  { path: 'nosotros', component: NosotrosComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
