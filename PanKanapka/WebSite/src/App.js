import React, { Component, Fragment } from "react";
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
      Role: null,
      AuthID: null,
      CateringFirmId: null,
      Name: null,
      Surname: null,
      CateringFirmName: null
    };
  }

  userHasAuthenticated = authenticated => {
    this.setState({ isAuthenticated: authenticated });
  }

  setAuthId = Id => {
    this.setState({ AuthID: Id });
  }

  setCateringFirmId = Id => {
    this.setState({ CateringFirmId: Id });
  }

  setName = n => {
    this.setState({ Name: n });
  }

  setSurname = sn => {
    this.setState({ Surname: sn });
  }

  setCateringFirmName = n => {
    this.setState({ CateringFirmName: n });
  }

  handleLogout = event => {
    this.userHasAuthenticated(false);
  }

  render() {
    const childProps = {
      isAuthenticated: this.state.isAuthenticated,
      userHasAuthenticated: this.userHasAuthenticated, 

      CateringFirmName:this.state.CateringFirmName, 
      CateringFirmId:this.state.CateringFirmId,  
      setAuthId: this.setAuthId,
      setCateringFirmId: this.setCateringFirmId,
      setName: this.setName,
      setSurname: this.setSurname,
      setCateringFirmName: this.setCateringFirmName
    };


    return (
      <BrowserRouter>
        <div className="App">
          <Navbar  childProps={childProps}/>
          <Routes  childProps={childProps}/>
          <Footer  childProps={childProps} />
         
        </div>
      </BrowserRouter>
    );
  }
  
}

export default App;