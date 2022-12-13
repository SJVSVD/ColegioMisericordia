<?php

namespace App\Http\Controllers;

use App\Http\Requests\AlumnosRequest;
use App\Models\Alumnos;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AlumnosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Alumnos::all();
    }
    public function getXNivel(int $cod_nivel){
        return Alumnos::select('rut', 'nombre', 'fechaNacimiento', 'foto', 'sexo',  'cod_nivel')
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

    public function getCantAlumnos(int $cod_nivel){
        return Alumnos::join('nivel', 'nivel.cod_nivel', '=', 'alumnos.cod_nivel')
        ->where('nivel.cod_nivel', '=', $cod_nivel)
        ->select (DB::raw('count(*) as cantidad'))->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(AlumnosRequest $request)
    {
        $alumnos = new Alumnos();
        $alumnos->rut = $request->rut;
        $alumnos->nombre = $request->nombre;
        $alumnos->fechaNacimiento = $request->fechaNacimiento;
        $alumnos->foto = $request->foto;
        $alumnos->sexo = $request->sexo;
        $alumnos->cod_nivel = $request->cod_nivel;
        $alumnos->save();
        return  $alumnos;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Alumnos  $alumnos
     * @return \Illuminate\Http\Response
     */
    public function show(Alumnos $alumnos)
    {
        $url = url()->current();
        $rut = explode("/", $url)[5];
        $alumnos = Alumnos::find($rut);
        return $alumnos;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Alumnos  $alumnos
     * @return \Illuminate\Http\Response
     */
    public function edit(Alumnos $alumnos)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Alumnos  $alumnos
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Alumnos $alumnos)
    {
        $url = url()->current();
        $rut = explode("/", $url)[5];
        $alumnos = Alumnos::find($rut);
        $alumnos->nombre = $request->nombre;
        $alumnos->fechaNacimiento = $request->fechaNacimiento;
        $alumnos->foto = $request->foto;
        $alumnos->sexo = $request->sexo;
        $alumnos->cod_nivel = $request->cod_nivel;
        $alumnos->save();
        return  $alumnos;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Alumnos  $alumnos
     * @return \Illuminate\Http\Response
     */
    public function destroy(Alumnos $alumnos)
    {   
        $url = url()->current();
        $rut = explode("/", $url)[5];
        $alumnos = Alumnos::find($rut);
        $alumnos->delete();
        return $alumnos;
    }
}
