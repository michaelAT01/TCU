import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PresentacionComponent } from './components/presentacion/presentacion.component';
import { AgriculturaComponent } from './components/agricultura/agricultura.component';
import { NosotrosComponent } from './components/nosotros/nosotros.component';
import { AgregarComponent } from './components/agregar/agregar.component';

@NgModule({
  declarations: [
    AppComponent,
    PresentacionComponent,
    AgriculturaComponent,
    NosotrosComponent,
    AgregarComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
