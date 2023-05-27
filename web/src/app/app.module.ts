import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import {MatCardModule} from "@angular/material/card";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatButtonModule} from "@angular/material/button";
import {MatIconModule} from "@angular/material/icon";
import {MatInputModule} from "@angular/material/input";
import {RouterModule, RouterOutlet, Routes} from "@angular/router";
import { HomeComponent } from './home/home.component';

import {MatToolbarModule} from "@angular/material/toolbar";
import { FactureComponent } from './facture/facture.component';
import { NavbarComponent } from './navbar/navbar.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { UserinfoComponent } from './userinfo/userinfo.component';

import { HttpClientModule } from '@angular/common/http';
import { RechargeComponent } from './recharge/recharge.component';
import { DonationComponent } from './donation/donation.component';
import { HistoriqueComponent } from './historique/historique.component';
import { PayementpageComponent } from './payementpage/payementpage.component';
import { RechargepageComponent } from './rechargepage/rechargepage.component';






const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'home', component: HomeComponent},
  { path: 'facture', component: FactureComponent},
  { path: 'userinfo', component: UserinfoComponent},

  { path: 'userinfo', component: UserinfoComponent},
  { path: 'recharge', component: RechargeComponent},
  { path: 'historique', component: HistoriqueComponent},
  { path: 'facture', component: FactureComponent},
  { path: 'payementpage', component: PayementpageComponent},
  { path: 'recharge', component: RechargeComponent },
  { path: 'rechargepage', component: RechargepageComponent },
  { path: 'donation', component: DonationComponent },








];
@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    FactureComponent,
    NavbarComponent,
    UserinfoComponent,

    RechargeComponent,
    DonationComponent,
    HistoriqueComponent,
    PayementpageComponent,
    RechargepageComponent,






  ],
  imports: [
    BrowserModule,
    MatSlideToggleModule,
    MatCardModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatButtonModule,
    MatIconModule,
    MatInputModule,
    RouterOutlet,
    RouterModule.forRoot(routes),
    MatToolbarModule,
    BrowserAnimationsModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
