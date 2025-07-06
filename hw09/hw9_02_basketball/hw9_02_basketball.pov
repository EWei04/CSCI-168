#version 3.7;
// Render Settings: Any frame, no AA, +KFF10
// Camera setup
camera {
    perspective
    location <0, 3, 7>
    look_at <0, 1, 0>
    angle 60
}

// Lighting
light_source {
    <5, 10, 5>
    color rgb <0.8, 0.8, 0.8>
}

light_source {
    <-5, 10, 5>
    color rgb <0.5, 0.5, 0.5>
}

// Background
background { color rgb <0.5, 0.5, 0.5> }

// Floor with texture
plane {
    y, 0
    texture {
        pigment {
            brick      
            color rgb <0.3, 0.3, 0.3>   // Grout
            color rgb <0.7, 0.3, 0.1>  // Tile
     
            brick_size <2.25, 1, 2.25>         
            mortar 0.1
        }
        finish {
            ambient 0.2
            diffuse 0.8
            roughness 0.8
        }
    }
}



// Wall
plane {
    z, -2
    texture {
        pigment {
            image_map {
                jpeg "wall_texture.jpg"  
                map_type 0
            }
            scale <30, 10, 1>
        }
        finish {
            ambient 0.2
            diffuse 0.8
            roughness 0.8
        }
    }
}   

// Basketball Animation
#declare ball_radius = 0.95;

// Physics parameters
#declare gravity = -9.8;
#declare damping = 0.6;  
#declare horizontal_velocity = -2.75;  
#declare initial_height = 5.0; 
#declare initial_vertical_velocity = 0.0;


#declare total_time = 4;  // Total animation time in seconds
#declare current_time = clock * total_time;
#declare dt = total_time / 60;  // Small time step for physics calculation


#declare pos_x = 5.0;  // Starting x position
#declare pos_y = initial_height;  // Starting y position
#declare vel_y = initial_vertical_velocity;  // Starting vertical velocity
#declare time_step = 0;

// Physics simulation loop
#while (time_step < current_time)
    #declare pos_x = pos_x + horizontal_velocity * dt;
    #declare pos_y = pos_y + vel_y * dt;
    

    #declare vel_y = vel_y + gravity * dt;
    
    // Check for ground collision
    #if (pos_y <= ball_radius)
        #declare pos_y = ball_radius;  // Keep ball on ground
        #if (vel_y < 0)  // Only bounce if moving downward
            #declare vel_y = -vel_y * damping;  // Reverse and dampen velocity
        #end
    #end
    
    #declare time_step = time_step + dt;
#end


#declare current_x = pos_x;
#declare current_y = pos_y;

// Rotation based on horizontal movement and time
#declare rotation_amount = current_x * 1.5;

// Basketball sphere
sphere {
    <0, 0, 0>, ball_radius
    
    texture {
        pigment {
            image_map {
                jpeg "basketball_texture.jpg"
                map_type 1  // Spherical mapping
            }
        }
        finish {
            ambient 0.1
            diffuse 0.8
            specular 0.3
            roughness 0.02
        }
    }

    
    // Apply rotation around z-axis
    rotate <0, 0, rotation_amount * 57.2958>
    
 
    translate <current_x, current_y, 0>
}
