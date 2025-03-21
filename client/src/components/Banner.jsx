import manzanillaImagen from "../../public/IMG_0453.jpg";

const Banner = () => {
    return (
        <div className="relative w-full h-screen overflow-hidden flex items-center">
            <h1 className="absolute top-4 left-4 text-white text-2xl font-bold bg-black bg-opacity-50 p-2 rounded-lg">
                Título del Banner
            </h1>
            <img 
                src={manzanillaImagen} 
                alt="manzanilla" 
                className="w-full h-1/2 object-cover"
            />
        </div>
    );
};

export default Banner;
