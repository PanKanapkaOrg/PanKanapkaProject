import React, { Component } from "react";
import { BrowserRouter } from "react-router-dom";
import "./App.css";

import Navbar from "./components/layout/Navbar"
import Footer from "./components/layout/Footer"
import Routes from "./Routes";

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isAuthenticated: false,
      role: null,
      authId: null,
      cateringFirmId: null,
      managerName: null,
      managerSurname: null,
      cateringFirmName: null,
      cateringFirmAddress: null, 
      cateringFirmInfo: null,
      logoUrl: null
    };
  }

  setAppStateProperty = (property, value) => {
    if(this.state.hasOwnProperty(property)) {
      var updatedState = this.state;
      updatedState[property] = value;
      this.setState(updatedState);
    }
    else {
      console.log('Property is not exist in App state ' + property);
    }
  }

  render() {
    const childProps = {
      isAuthenticated: this.state.isAuthenticated,
      cateringFirmName: this.state.cateringFirmName, 
      cateringFirmId: this.state.cateringFirmId,
      managerName: this.state.managerName,
      managerSurname: this.state.managerSurname,
      logoUrl: this.state.logoUrl,
      cateringFirmAddress:this.state.cateringFirmAddress,
      cateringFirmInfo:this.state.cateringFirmInfo,
      setAppStateProperty: this.setAppStateProperty
    };

    return (
      <BrowserRouter>
        <div className="App">
          <Navbar  isAuthenticated={childProps.isAuthenticated} managerName={childProps.managerName} managerSurname={childProps.managerSurname} handleLogout={() => this.setAppStateProperty("isAuthenticated",false)}/>
          <Routes  childProps={childProps}/>
          <Footer  childProps={childProps} />
         
        </div>
      </BrowserRouter>
    );
  }
  
}

export default App;