<?php

namespace App\Http\Controllers;

use App\Models\Nivel;
use Illuminate\Http\Request;
use App\Http\Requests\NivelRequest;
class NivelController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Nivel::all();
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
    public function store(NivelRequest $request)
    {
        $nivel = new Nivel();
        $nivel->cod_nivel = $request->cod_nivel;
        $nivel->nombre_nivel = $request->nombre_nivel;
        $nivel->imagen = $request->imagen;
        $nivel->save();
        return $nivel;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function show(Nivel $nivel)
    {
        return $nivel;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function edit(Nivel $nivel)
    {
        
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function update(NivelRequest $request, Nivel $nivel)
    {
        $nivel->nombre_nivel = $request->nombre_nivel;
        $nivel->imagen = $request->imagen;
        $nivel->save();
        return $nivel;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Nivel  $nivel
     * @return \Illuminate\Http\Response
     */
    public function destroy(Nivel $nivel)
    {
        $nivel->delete();
    }
}
