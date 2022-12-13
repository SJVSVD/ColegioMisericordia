<?php

namespace App\Http\Controllers;

use App\Models\Educadores;
use Illuminate\Http\Request;
use App\Http\Requests\EducadoresRequest;

class EducadoresController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Educadores::all();
    }
    public function getXNivel(int $cod_nivel){
        return Educadores::select('rut', 'nombre','email', 'fechaNacimiento', 'telefono', 'sexo',  'cod_nivel')
        ->where('cod_nivel', '=', $cod_nivel)->get();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(EducadoresRequest $request)
    {
        $educadores = new Educadores();
        $educadores->rut = $request->rut;
        $educadores->nombre = $request->nombre;
        $educadores->fechaNacimiento = $request->fechaNacimiento;
        $educadores->telefono = $request->telefono;
        $educadores->email = $request->email;
        $educadores->sexo = $request->sexo;
        $educadores->cod_nivel = $request->cod_nivel;
        $educadores->save();
        return $educadores;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Educadores $educadores
     * @return \Illuminate\Http\Response
     */
    public function show(Educadores $educadores)
    {
        $url = url()->current();
        $rut = explode("/", $url)[5];
        $educadores = Educadores::find($rut);
        return $educadores;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Educadores  $educadores
     * @return \Illuminate\Http\Response
     */
    public function edit(Educadores $educadores)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Educadores  $educadores
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Educadores $educadores)
    {
        $url = url()->current();
        $rut = explode("/", $url)[5];
        $educadores = Educadores::find($rut);
        $educadores->nombre = $request->nombre;
        $educadores->fechaNacimiento = $request->fechaNacimiento;
        $educadores->telefono = $request->telefono;
        $educadores->email = $request->email;
        $educadores->sexo = $request->sexo;
        $educadores->cod_nivel = $request->cod_nivel;
        $educadores->save();
        return  $educadores;

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Educadores  $educadores
     * @return \Illuminate\Http\Response
     */
    public function destroy(Educadores $educadores)
    {
        $url = url()->current();
        $rut = explode("/", $url)[5];
        $educadores = Educadores::find($rut);
        $educadores->delete();
    }
}
